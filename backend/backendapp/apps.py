from django.apps import AppConfig
from tensorflow import keras
from pathlib import Path
import tensorflow as tf
import numpy as np
import io
from PIL import Image
import base64
import hashlib
import random

tf.compat.v1.logging.set_verbosity(tf.compat.v1.logging.ERROR)
class BackendappConfig(AppConfig):
    
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'backendapp'
    
    # Définition des paths des modèles
    PLANT_DETECTOR_PATH = Path("backendapp/model/plant_detector")
    SICKNESS_DETECTOR_PATH = Path("backendapp/model/sickness_detector")
    #DICT contenant le nom des plantes (ne pas changer l'ordre, p-e mettre en base)
    PLANT_NAMES = ['Acanthaceae', 'Aceraceae', 'Achariaceae', 'Achatocarpaceae', 'Acoraceae', 'Actinidiaceae', 'Adoxaceae', 'Agavaceae', 'Aizoaceae', 'Alismataceae', 'Alseuosmiaceae', 'Alstroemeriaceae', 'Altingiaceae', 'Amaranthaceae', 'Amaryllidaceae', 'Amborellaceae', 'Anacampserotaceae', 'Anacardiaceae', 'Anemiaceae', 'Anisophylleaceae', 'Annonaceae', 'Apiaceae', 'Apocynaceae', 'Aquifoliaceae', 'Araceae', 'Araliaceae', 'Araucariaceae', 'Arecaceae', 'Argophyllaceae', 'Aristolochiaceae', 'Asclepiadaceae', 'Asparagaceae', 'Aspleniaceae', 'Asteliaceae', 'Asteraceae', 'Athyriaceae', 'Azollaceae', 'Balanophoraceae', 'Balsaminaceae', 'Basellaceae', 'Bataceae', 'Begoniaceae', 'Berberidaceae', 'Betulaceae', 'Bignoniaceae', 'Bixaceae', 'Blechnaceae', 'Boraginaceae', 'Brassicaceae', 'Bromeliaceae', 'Buddlejaceae', 'Burseraceae', 'Buxaceae', 'Byblidaceae', 'Cactaceae', 'Calceolariaceae', 'Callitrichaceae', 'Calophyllaceae', 'Calycanthaceae', 'Campanulaceae', 'Canellaceae', 'Cannabaceae', 'Cannaceae', 'Capparaceae', 'Caprifoliaceae', 'Caricaceae', 'Caryophyllaceae', 'Casuarinaceae', 'Celastraceae', 'Centrolepidaceae', 'Cephalotaceae', 'Chenopodiaceae', 'Chloranthaceae', 'Chrysobalanaceae', 'Cistaceae', 'Cleomaceae', 'Clethraceae', 'Clusiaceae', 'Colchicaceae', 'Combretaceae', 'Commelinaceae', 'Compositae', 'Connaraceae', 'Convolvulaceae', 'Coriariaceae', 'Cornaceae', 'Costaceae', 'Crassulaceae', 'Cucurbitaceae', 'Cunoniaceae', 'Cupressaceae', 'Cuscutaceae', 'Cyatheaceae', 'Cycadaceae', 'Cyclanthaceae', 'Cyperaceae', 'Cyrillaceae', 'Cytinaceae', 'Dennstaedtiaceae', 'Diapensiaceae', 'Dichapetalaceae', 'Didiereaceae', 'Dilleniaceae', 'Dioscoreaceae', 'Dipsacaceae', 'Dipterocarpaceae', 'Droseraceae', 'Drosophyllaceae', 'Dryopteridaceae', 'Ebenaceae', 'Elaeagnaceae', 'Elaeocarpaceae', 'Elatinaceae', 'Empetraceae', 'Ephedraceae', 'Equisetaceae', 'Ericaceae', 'Eriocaulaceae', 'Erythroxylaceae', 'Eucommiaceae', 'Euphorbiaceae', 'Fabaceae', 'Fagaceae', 'Flacourtiaceae', 'Flagellariaceae', 'Fouquieriaceae', 'Frankeniaceae', 'Fumariaceae', 'Garryaceae', 'Gentianaceae', 'Geraniaceae', 'Gerrardinaceae', 'Gesneriaceae', 'Gleicheniaceae', 'Gnetaceae', 'Goodeniaceae', 'Grossulariaceae', 'Gunneraceae', 'Haemodoraceae', 'Haloragaceae', 'Hamamelidaceae', 'Heliconiaceae', 'Helwingiaceae', 'Hernandiaceae', 'Hippocastanaceae', 'Hippocrateaceae', 'Hippuridaceae', 'Hydatellaceae', 'Hydnoraceae', 'Hydrangeaceae', 'Hydrocharitaceae', 'Hydroleaceae', 'Hydrophyllaceae', 'Hydrostachyaceae', 'Hymenophyllaceae', 'Hypericaceae', 'Hypoxidaceae', 'Icacinaceae', 'Iridaceae', 'Isoëtaceae', 'Juglandaceae', 'Juncaceae', 'Juncaginaceae', 'Kirkiaceae', 'Krameriaceae', 'Lacistemataceae', 'Lamiaceae', 'Lardizabalaceae', 'Lauraceae', 'Lecythidaceae', 'Leguminosae', 'Leitneriaceae', 'Lemnaceae', 'Lennoaceae', 'Lentibulariaceae', 'Liliaceae', 'Limeaceae', 'Limnanthaceae', 'Linaceae', 'Linderniaceae', 'Lindsaeaceae', 'Loasaceae', 'Loganiaceae', 'Lomariopsidaceae', 'Lophiocarpaceae', 'Loranthaceae', 'Lowiaceae', 'Lycopodiaceae', 'Lygodiaceae', 'Lythraceae', 'Magnoliaceae', 'Malpighiaceae', 'Malvaceae', 'Marantaceae', 'Marattiaceae', 'Marcgraviaceae', 'Marsileaceae', 'Martyniaceae', 'Melanthiaceae', 'Melastomataceae', 'Meliaceae', 'Melianthaceae', 'Menispermaceae', 'Menyanthaceae', 'Misodendraceae', 'Molluginaceae', 'Monimiaceae', 'Monotropaceae', 'Montiaceae', 'Moraceae', 'Moringaceae', 'Musaceae', 'Myoporaceae', 'Myricaceae', 'Myristicaceae', 'Myrsinaceae', 'Myrtaceae', 'Najadaceae', 'Nartheciaceae', 'Nelumbonaceae', 'Nepenthaceae', 'Nothofagaceae', 'Nyctaginaceae', 'Nymphaeaceae', 'Ochnaceae', 'Olacaceae', 'Oleaceae', 'Onagraceae', 'Onocleaceae', 'Ophioglossaceae', 'Opiliaceae', 'Orchidaceae', 'Orobanchaceae', 'Osmundaceae', 'Oxalidaceae', 'Paeoniaceae', 'Pandanaceae', 'Papaveraceae', 'Parkeriaceae', 'Passifloraceae', 'Paulowniaceae', 'Pedaliaceae', 'Pentaphylacaceae', 'Peraceae', 'Phrymaceae', 'Phyllanthaceae', 'Phytolaccaceae', 'Picramniaceae', 'Picrodendraceae', 'Pinaceae', 'Piperaceae', 'Pittosporaceae', 'Plantaginaceae', 'Platanaceae', 'Plumbaginaceae', 'Poaceae', 'Podocarpaceae', 'Podostemaceae', 'Polemoniaceae', 'Polygalaceae', 'Polygonaceae', 'Polypodiaceae', 'Pontederiaceae', 'Portulacaceae', 'Potamogetonaceae', 'Primulaceae', 'Proteaceae', 'Psilotaceae', 'Pteridaceae', 'Punicaceae', 'Putranjivaceae', 'Pyrolaceae', 'Rafflesiaceae', 'Ranunculaceae', 'Resedaceae', 'Rhamnaceae', 'Rhizophoraceae', 'Roridulaceae', 'Rosaceae', 'Rubiaceae', 'Rutaceae', 'Salicaceae', 'Salvadoraceae', 'Salviniaceae', 'Santalaceae', 'Sapindaceae', 'Sapotaceae', 'Sarraceniaceae', 'Saururaceae', 'Saxifragaceae', 'Scheuchzeriaceae', 'Schisandraceae', 'Schizaeaceae', 'Schoepfiaceae', 'Scrophulariaceae', 'Selaginellaceae', 'Simaroubaceae', 'Siparunaceae', 'Smilacaceae', 'Solanaceae', 'Sparganiaceae', 'Sphenocleaceae', 'Stachyuraceae', 'Staphyleaceae', 'Sterculiaceae', 'Stilbaceae', 'Strelitziaceae', 'Stylidiaceae', 'Styracaceae', 'Surianaceae', 'Talinaceae', 'Tamaricaceae', 'Taxaceae', 'Tecophilaeaceae', 'Tectariaceae', 'Theaceae', 'Thelypteridaceae', 'Thymelaeaceae', 'Tiliaceae', 'Tofieldiaceae', 'Trigoniaceae', 'Tropaeolaceae', 'Turneraceae', 'Typhaceae', 'Ulmaceae', 'Urticaceae', 'Vahliaceae', 'Valerianaceae', 'Verbenaceae', 'Violaceae', 'Viscaceae', 'Vitaceae', 'Vochysiaceae', 'Winteraceae', 'Woodsiaceae', 'Xanthorrhoeaceae', 'Xyridaceae', 'Zamiaceae', 'Zingiberaceae', 'Zosteraceae', 'Zygophyllaceae']
    SICKNESS_NAMES = ['Healthy', 'Powdery', 'Rust']
    ALPHABET = "!.;,:/*$£~&0-^@)([]=+}{123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    # Charge les modèles. En les chargeant dans ce fichier, ils sont chargés au lancement de l'app et utilisable par la suite sans avoir
    # besoin de les charger à chaque appel API
    with tf.device('/device:CPU:0'):
        plant_detector_model = keras.models.load_model(PLANT_DETECTOR_PATH)
        sickness_detector_model = keras.models.load_model(SICKNESS_DETECTOR_PATH)
        
    def decode_image(encodedImage):
        """Decode image à partir du string base"""
        b = encodedImage.encode("utf-8")
        base64_bytes = base64.b64decode(b)
        image = open("image.png", "wb")
        image.write(base64_bytes)
        image.close()
        
    def encode_image(image):
        """Encode et resize l'img de base
        
        Parameters
        ----------
        image : PIL.Image instance
            Image à encoder avant traitement IA
            
        Returns
        -------
        img_array
            Un batch d'array numpy correspondant à l'image, prêt à être fourni aux modèles pour prédictions
        """

        img = tf.keras.utils.load_img(
            image, target_size=(128, 128)
        )
        img_array = tf.keras.utils.img_to_array(img)/255
        img_array = tf.expand_dims(img_array, 0) # Create a batch
        return img_array
    
    def prediction_plant(image):
        """Prévision à partir de l'img encodée, retourne la classe et la probabilité
        
        Parameters
        ----------
        image : PIL.Image instance
            Image à encoder avant traitement IA
            
        Returns
        -------
        Predictions
            Un Array : 
                Array[0] = nom de la famille de plante, 
                Array[1] = % de précision du modèle
        """
        
        img = BackendappConfig.encode_image(image)
        predictions = BackendappConfig.plant_detector_model.predict(img)
        score = tf.nn.softmax(predictions[0])
        return [BackendappConfig.PLANT_NAMES[int(np.argmax(score))],  float(100 * np.max(score))]
    
    def prediction_sickness(image):
        """Prévision à partir de l'img encodée, retourne la classe et la probabilité
        
        Parameters
        ----------
        image : PIL.Image instance
            Image à encoder avant traitement IA
            
        Returns
        -------
        Predictions
            Un Array : 
                Array[0] = 'Healthy' ou 'Powdery' ou 'Rust'
                Array[1] = % de précision du modèle
        """
        img = BackendappConfig.encode_image(image)
        predictions = BackendappConfig.sickness_detector_model.predict(img)
        score = tf.nn.softmax(predictions[0])
        return [BackendappConfig.PLANT_NAMES[int(np.argmax(score))],  float(100 * np.max(score))]
    
    
    def encode_password(raw_password, salt):
        """Encode le password avant enregistrement en base
        
        Parameters
        ----------
        raw_password : str
            password à encoder
            
        Returns
        -------
        Encoded password: str
        """
        
        saltedPassword = raw_password.encode('utf-8') + salt.encode('utf-8')
        encodedPassword = hashlib.sha256(saltedPassword).hexdigest()
        return encodedPassword
        
    def get_salt():
        alphbt = BackendappConfig.ALPHABET
        salt = ''.join(random.choice(alphbt) for i in range(24))
        return salt