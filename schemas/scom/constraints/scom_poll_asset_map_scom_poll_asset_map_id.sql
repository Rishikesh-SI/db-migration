-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_poll_asset_map scom_poll_asset_map_id
-- Type: CONSTRAINT

-- Name: scom_poll_asset_map scom_poll_asset_map_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_poll_asset_map
    ADD CONSTRAINT scom_poll_asset_map_id PRIMARY KEY (poll_asset_map_id);


--
