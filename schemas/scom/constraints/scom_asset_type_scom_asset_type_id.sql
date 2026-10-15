-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_asset_type scom_asset_type_id
-- Type: CONSTRAINT

-- Name: scom_asset_type scom_asset_type_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_asset_type
    ADD CONSTRAINT scom_asset_type_id PRIMARY KEY (asset_type_id);


--
