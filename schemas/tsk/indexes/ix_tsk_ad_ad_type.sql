-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_ad_ad_type
-- Type: INDEX

-- Name: ix_tsk_ad_ad_type; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_ad_ad_type ON tsk.tsk_ad USING btree (ad_type);


--
