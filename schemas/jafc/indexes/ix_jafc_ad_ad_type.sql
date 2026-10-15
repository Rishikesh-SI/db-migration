-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_ad_ad_type
-- Type: INDEX

-- Name: ix_jafc_ad_ad_type; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_ad_ad_type ON jafc.jafc_ad USING btree (ad_type);


--
