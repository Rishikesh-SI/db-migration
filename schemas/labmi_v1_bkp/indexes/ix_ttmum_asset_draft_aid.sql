-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: ix_ttmum_asset_draft_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_aid; Type: INDEX; Schema: labmi_v1_bkp; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_aid ON labmi_v1_bkp.labmi_v1_asset_draft USING btree (asset_id);


--
