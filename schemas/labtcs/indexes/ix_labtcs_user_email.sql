-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_labtcs_user_email
-- Type: INDEX

-- Name: ix_labtcs_user_email; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_labtcs_user_email ON labtcs.labtcs_user_master USING btree (upper(email_id));


--
