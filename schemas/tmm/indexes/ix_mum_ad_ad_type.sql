-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_ad_ad_type
-- Type: INDEX

-- Name: ix_mum_ad_ad_type; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_ad_ad_type ON tmm.tmm_ad USING btree (ad_type);


--
