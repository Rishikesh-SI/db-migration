-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_asset_list scom_asset_list_id
-- Type: CONSTRAINT

-- Name: scom_asset_list scom_asset_list_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_asset_list
    ADD CONSTRAINT scom_asset_list_id PRIMARY KEY (asset_list_id);


--
