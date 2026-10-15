-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_asset_group labmi_asset_group_id
-- Type: CONSTRAINT

-- Name: labmi_asset_group labmi_asset_group_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_asset_group
    ADD CONSTRAINT labmi_asset_group_id PRIMARY KEY (asset_group_id);


--
