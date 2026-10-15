-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_asset_draft_atid
-- Type: INDEX

-- Name: ix_kxp_asset_draft_atid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_asset_draft_atid ON kxp.kxp_asset_draft USING btree (asset_type_id);


--
