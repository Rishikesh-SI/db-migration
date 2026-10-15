-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_asset_list_atid
-- Type: INDEX

-- Name: ix_hsl_asset_list_atid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_atid ON labhsl.labhsl_asset_list USING btree (asset_type_id);


--
