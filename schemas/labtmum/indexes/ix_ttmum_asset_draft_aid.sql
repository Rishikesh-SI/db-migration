-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_asset_draft_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_aid; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_aid ON labtmum.labtmum_asset_draft USING btree (asset_id);


--
