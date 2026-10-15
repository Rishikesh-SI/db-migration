-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_draft_aid
-- Type: INDEX

-- Name: ix_stn_asset_draft_aid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_draft_aid ON stn.stn_asset_draft USING btree (asset_id);


--
