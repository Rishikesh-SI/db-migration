-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_asset_group labyho_asset_group_id
-- Type: CONSTRAINT

-- Name: labdms_asset_group labyho_asset_group_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_asset_group
    ADD CONSTRAINT labyho_asset_group_id PRIMARY KEY (asset_group_id);


--
