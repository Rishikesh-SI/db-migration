-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: ix_ttmum_asset_draft_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_aid; Type: INDEX; Schema: labmcfc_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_aid ON labmcfc_v1.labmcfc_v1_asset_draft USING btree (asset_id);


--
