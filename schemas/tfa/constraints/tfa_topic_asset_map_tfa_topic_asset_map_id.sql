-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_topic_asset_map tfa_topic_asset_map_id
-- Type: CONSTRAINT

-- Name: tfa_topic_asset_map tfa_topic_asset_map_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_topic_asset_map
    ADD CONSTRAINT tfa_topic_asset_map_id PRIMARY KEY (topic_asset_map_id);


--
