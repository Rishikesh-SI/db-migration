-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_ad_ad_type
-- Type: INDEX

-- Name: ix_spz_ad_ad_type; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_ad_ad_type ON spz.spz_ad USING btree (ad_type);


--
