-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_asset_draft_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_aid; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_aid ON labboost.labboost_asset_draft USING btree (asset_id);


--
