-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_yho_ad
-- Type: INDEX

-- Name: ix_yho_ad; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_yho_ad ON labdms.labdms_advertisement USING btree (ad_position, is_published, is_default);


--
