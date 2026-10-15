-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_asset_draft_aid
-- Type: INDEX

-- Name: ix_kxp_asset_draft_aid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_asset_draft_aid ON kxp.kxp_asset_draft USING btree (asset_id);


--
