-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_asset_draft_atid
-- Type: INDEX

-- Name: ix_mum_asset_draft_atid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_asset_draft_atid ON tmm.tmm_asset_draft USING btree (asset_type_id);


--
