-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_asset_draft_aid
-- Type: INDEX

-- Name: ix_kxp_asset_draft_aid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_asset_draft_aid ON labstlz.labstlz_asset_draft USING btree (asset_id);


--
