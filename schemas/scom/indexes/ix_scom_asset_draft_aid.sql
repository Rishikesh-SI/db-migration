-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_asset_draft_aid
-- Type: INDEX

-- Name: ix_scom_asset_draft_aid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_asset_draft_aid ON scom.scom_asset_draft USING btree (asset_id);


--
