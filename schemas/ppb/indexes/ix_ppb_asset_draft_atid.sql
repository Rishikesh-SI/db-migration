-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_draft_atid
-- Type: INDEX

-- Name: ix_ppb_asset_draft_atid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_draft_atid ON ppb.ppb_asset_draft USING btree (asset_type_id);


--
