-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_asset_draft_atid
-- Type: INDEX

-- Name: ix_scup_asset_draft_atid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_asset_draft_atid ON u17wc.u17wc_asset_draft USING btree (asset_type_id);


--
