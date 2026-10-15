-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_ad_ad_type
-- Type: INDEX

-- Name: ix_kxp_ad_ad_type; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_ad_ad_type ON labstlz.labstlz_ad USING btree (ad_type);


--
