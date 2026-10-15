-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_ad_ad_type
-- Type: INDEX

-- Name: ix_kxp_ad_ad_type; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_ad_ad_type ON labkxp.labkxp_ad USING btree (ad_type);


--
