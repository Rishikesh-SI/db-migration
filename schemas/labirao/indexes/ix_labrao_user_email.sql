-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: ix_labrao_user_email
-- Type: INDEX

-- Name: ix_labrao_user_email; Type: INDEX; Schema: labirao; Owner: -
--

CREATE INDEX ix_labrao_user_email ON labirao.labirao_user_master USING btree (upper(email_id));


--
