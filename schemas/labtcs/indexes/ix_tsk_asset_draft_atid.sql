-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_asset_draft_atid
-- Type: INDEX

-- Name: ix_tsk_asset_draft_atid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_asset_draft_atid ON labtcs.labtcs_asset_draft USING btree (asset_type_id);


--
