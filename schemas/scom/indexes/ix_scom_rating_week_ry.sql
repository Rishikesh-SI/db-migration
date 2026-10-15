-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_rating_week_ry
-- Type: INDEX

-- Name: ix_scom_rating_week_ry; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_rating_week_ry ON scom.scom_rating_week USING btree (rating_year);


--
