-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_asset_draft_atid
-- Type: INDEX

-- Name: ix_pkl_asset_draft_atid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_asset_draft_atid ON labpkl_v1.labpkl_v1_asset_draft USING btree (asset_type_id);


--
