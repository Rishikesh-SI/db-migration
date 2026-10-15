-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_asset_list_atid
-- Type: INDEX

-- Name: ix_scom_asset_list_atid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_asset_list_atid ON scom.scom_asset_list USING btree (asset_type_id);


--
