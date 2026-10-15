-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_ad_ad_type
-- Type: INDEX

-- Name: ix_upp_ad_ad_type; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_ad_ad_type ON upp.upp_ad USING btree (ad_type);


--
