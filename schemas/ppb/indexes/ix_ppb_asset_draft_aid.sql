-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_draft_aid
-- Type: INDEX

-- Name: ix_ppb_asset_draft_aid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_draft_aid ON ppb.ppb_asset_draft USING btree (asset_id);


--
