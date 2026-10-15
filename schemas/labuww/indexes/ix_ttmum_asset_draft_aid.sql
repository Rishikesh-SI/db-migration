-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_asset_draft_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_aid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_aid ON labuww.labuww_asset_draft USING btree (asset_id);


--
