-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_topic_asset_map scom_topic_asset_map_id
-- Type: CONSTRAINT

-- Name: scom_topic_asset_map scom_topic_asset_map_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_topic_asset_map
    ADD CONSTRAINT scom_topic_asset_map_id PRIMARY KEY (topic_asset_map_id);


--
