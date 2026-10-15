-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_ad_ad_type
-- Type: INDEX

-- Name: ix_isl_ad_ad_type; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_ad_ad_type ON isl.isl_ad USING btree (ad_type);


--
