-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_asset_group labwf_asset_group_id
-- Type: CONSTRAINT

-- Name: labwf_asset_group labwf_asset_group_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_asset_group
    ADD CONSTRAINT labwf_asset_group_id PRIMARY KEY (asset_group_id);


--
