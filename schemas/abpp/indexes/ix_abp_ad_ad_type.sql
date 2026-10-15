-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_ad_ad_type
-- Type: INDEX

-- Name: ix_abp_ad_ad_type; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_ad_ad_type ON abpp.abp_ad USING btree (ad_type);


--
