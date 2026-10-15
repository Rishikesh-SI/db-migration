-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_rating_week_wn
-- Type: INDEX

-- Name: ix_scom_rating_week_wn; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_rating_week_wn ON scom.scom_rating_week USING btree (week_number);


--
