-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_ad_ad_type
-- Type: INDEX

-- Name: ix_hsl_ad_ad_type; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_ad_ad_type ON hsl.hsl_ad USING btree (ad_type);


--
