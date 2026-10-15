-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_labisl_v1_user_emailid
-- Type: INDEX

-- Name: ix_labisl_v1_user_emailid; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_labisl_v1_user_emailid ON labisl_v1.labisl_v1_user USING btree (email_id);


--
