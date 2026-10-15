-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_asset_draft_atid
-- Type: INDEX

-- Name: ix_pbl_asset_draft_atid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_asset_draft_atid ON pbl.pbl_asset_draft USING btree (asset_type_id);


--
