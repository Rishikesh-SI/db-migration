-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_asset_list_title_alias
-- Type: INDEX

-- Name: ix_scom_asset_list_title_alias; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_asset_list_title_alias ON scom.scom_asset_list USING btree (title_alias);


--
