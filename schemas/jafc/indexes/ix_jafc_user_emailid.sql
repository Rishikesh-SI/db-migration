-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_user_emailid
-- Type: INDEX

-- Name: ix_jafc_user_emailid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_user_emailid ON jafc.jafc_user USING btree (email_id);


--
