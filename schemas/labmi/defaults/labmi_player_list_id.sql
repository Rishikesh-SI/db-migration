-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_player_list id
-- Type: DEFAULT

-- Name: labmi_player_list id; Type: DEFAULT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_player_list ALTER COLUMN id SET DEFAULT nextval('labmi.labmi_player_list_id_seq'::regclass);


--
