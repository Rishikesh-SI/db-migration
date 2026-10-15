-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_user_role_uid
-- Type: INDEX

-- Name: ix_jafc_user_role_uid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_user_role_uid ON jafc.jafc_user_role USING btree (user_id);


--
