-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_dummy_aiatipvn
-- Type: INDEX

-- Name: ix_abp_dummy_aiatipvn; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_dummy_aiatipvn ON abpp.abp_dummy USING btree (asset_id, asset_type_id, published_version_number);


--
