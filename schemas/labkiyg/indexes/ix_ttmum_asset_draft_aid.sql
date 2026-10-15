-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_asset_draft_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_aid; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_aid ON labkiyg.labkiyg_asset_draft USING btree (asset_id);


--
