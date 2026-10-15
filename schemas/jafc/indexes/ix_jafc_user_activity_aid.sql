-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_user_activity_aid
-- Type: INDEX

-- Name: ix_jafc_user_activity_aid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_user_activity_aid ON jafc.jafc_user_activity USING btree (user_id);


--
