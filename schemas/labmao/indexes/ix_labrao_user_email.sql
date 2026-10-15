-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_labrao_user_email
-- Type: INDEX

-- Name: ix_labrao_user_email; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_labrao_user_email ON labmao.labmao_user_master USING btree (upper(email_id));


--
