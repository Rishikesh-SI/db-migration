-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_ad_ad_type
-- Type: INDEX

-- Name: ix_pkl_ad_ad_type; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_ad_ad_type ON msl.msl_ad USING btree (ad_type);


--
