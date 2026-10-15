-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_ad_ad_type
-- Type: INDEX

-- Name: ix_hsl_ad_ad_type; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_ad_ad_type ON labhsl.labhsl_ad USING btree (ad_type);


--
