-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_action_tracking_202001
-- Type: TABLE ATTACH

-- Name: labyho_user_action_tracking_202001; Type: TABLE ATTACH; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_user_action_tracking_2020 ATTACH PARTITION labyho.labyho_user_action_tracking_202001 FOR VALUES IN ('202001');


--
