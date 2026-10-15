-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_asset_list labyho_asset_list_id
-- Type: CONSTRAINT

-- Name: labdms_asset_list labyho_asset_list_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_asset_list
    ADD CONSTRAINT labyho_asset_list_id PRIMARY KEY (asset_list_id);


--
